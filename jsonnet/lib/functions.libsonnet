local manipulator(input, output, conditions, description) = {
  from: input,
} + {
  [o.to_type]: [o.output]
  for o in if std.isArray(output) then output else [output] + []
} + {
  [if conditions != null then 'conditions']: conditions,
  type: 'basic',
  description: description,
};

local rule_1m(description, input, output, conditions) = {
  description: description,
  manipulators: [
    manipulator(input, output, conditions, ''),
  ],
};

local rule(description, manipulators) = {
  description: description,
  manipulators: manipulators,
};

{

  // A rule specified using its manipulators
  //
  // description (string, required)
  //   description of the rule
  //
  // manipulators (array, required)
  //   array of manipulator() objects
  rule(description, manipulators):: rule(description, manipulators),


  // A quicker way to specify a simple rule with a single manipulator
  //
  // description (string, required)
  //   description of the rule
  //
  // input (object, required)
  //   input object for a rule; use input()
  //
  // output (object or array, required)
  //   output object for a rule; use outputKey() or outputShell()
  //
  // conditions (array, optional)
  rule_1m(description, input, output, conditions=null):: rule_1m(description, input, output, conditions),


  // manipulator
  //
  // input (object, required)
  //   input object for a rule; use input()
  //
  // output (object or array, required)
  //   output object for a rule; use outputKey() or outputShell()
  //
  // conditions (array, optional)
  //
  // description (string, optional)
  //   A human-readable comment
  manipulator(input, output, conditions=null, description='')::
    manipulator(input, output, conditions, description),


  // input
  //
  // key (string, required)
  //   key that will trigger a rule
  //
  // modifiers (array, optional)
  //   modifiers that, when combined with <key>, trigger a rule
  //
  // key_is_modifier (boolean, optional)
  //   removes entire 'modifiers' object; only use when <key> is a modifier itself
  input(key, modifiers=null, key_is_modifier=false):: {
    key_code: key,
    [if key_is_modifier then null else 'modifiers']: {
      [if modifiers != null then 'mandatory']: modifiers,
      optional: ['any'],
    },
  },

  // outputKey
  //
  // key (string, required)
  //   key to output when a rule is triggered
  //
  // modifiers (array, optional)
  //   modifiers to add to the key when a rule is triggered
  //
  // output_type (string, optional)
  //   type of 'to' object; should normally be left alone
  //
  // key_code (string, optional)
  //   type of output key code; change the default value for non-typical keys, e.g. media keys
  outputKey(key, modifiers=null, output_type='to', key_code='key_code'):: {
    to_type: output_type,
    output: {
      [key_code]: key,
      [if modifiers != null then 'modifiers']: modifiers,
    },
  },

  // outputShell
  //
  // command (string, required)
  //   the command to run when a rule is triggered
  outputShell(command):: {
    to_type: 'to',
    output: {
      shell_command: command,
    },
  },


  layer(name, simultaneous):: rule('layer_' + name, [
    {
      from: {
        simultaneous: simultaneous,
        simultaneous_options: {
          detect_key_down_uninterruptedly: true,
          key_down_order: 'insensitive',
          key_up_order: 'insensitive',
          key_up_when: 'any',
          to_after_key_up: [
            {
              set_variable: {
                name: 'layer_' + name,
                value: 0,
              },
            },
          ],
        },
      },
      to: [
        {
          set_variable: {
            name: 'layer_' + name,
            value: 1,
          },
        },
      ],
      type: 'basic',
    },
  ]),

}
