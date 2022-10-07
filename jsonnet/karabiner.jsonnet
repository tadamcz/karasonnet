//---------//
// IMPORTS //
//---------//

local conditions = import 'lib/conditions.libsonnet';
local devices = import 'lib/devices.libsonnet';
local f = import 'lib/functions.libsonnet';
local keys = import 'lib/keys.libsonnet';

//------//
// MAIN //
//------//


local map_function_keys_to_self = [{ from: { key_code: 'f1' }, to: [{ key_code: 'f1' }] }, { from: { key_code: 'f2' }, to: [{ key_code: 'f2' }] }, { from: { key_code: 'f3' }, to: [{ key_code: 'f3' }] }, { from: { key_code: 'f4' }, to: [{ key_code: 'f4' }] }, { from: { key_code: 'f5' }, to: [{ key_code: 'f5' }] }, { from: { key_code: 'f6' }, to: [{ key_code: 'f6' }] }, { from: { key_code: 'f7' }, to: [{ key_code: 'f7' }] }, { from: { key_code: 'f8' }, to: [{ key_code: 'f8' }] }, { from: { key_code: 'f9' }, to: [{ key_code: 'f9' }] }, { from: { key_code: 'f10' }, to: [{ key_code: 'f10' }] }, { from: { key_code: 'f11' }, to: [{ key_code: 'f11' }] }, { from: { key_code: 'f12' }, to: [{ key_code: 'f12' }] }];


{
  profiles:
    [
      {
        selected: true,
        name: 'Generated from karabiner.jsonnet',
        complex_modifications: {
          rules: [
            f.rule_1m(
              'Paste without formatting',
              f.input('v', ['command', 'option']),
              f.outputKey('v', ['option', 'command', 'shift']),
            ),

            f.rule(
              'Right hand key cluster for word scrolling [Kinesis]',
              [
                f.manipulator(
                  f.input(key, ['right_command', 'right_control']),
                  f.outputKey(key, ['option']),
                  conditions.kinesis_condition
                )
                for key in ['left_arrow', 'right_arrow', 'delete_or_backspace', 'delete_forward']
              ]
            ),

            f.rule_1m(
              'Caps Lock -> Hyper',
              f.input('caps_lock'),
              f.outputKey('left_shift', ['command', 'control', 'option']),
            ),

            f.rule(
              'Hyper + up/down arrows -> Scroll up/down',
              [
                f.manipulator(
                  f.input('down_arrow', keys.hyper),
                  f.outputKey({ vertical_wheel: 150 }, key_code='mouse_key'),
                ),

                f.manipulator(
                  f.input('up_arrow', keys.hyper),
                  f.outputKey({ vertical_wheel: -150 }, key_code='mouse_key'),
                ),
              ]
            ),

            f.rule_1m(
              'Hyper + ? -> Help menu',
              f.input('slash', keys.hyper),
              f.outputKey('slash', ['command', 'shift']),
            ),

            f.rule_1m(
              'PrintScr -> Switch windows of current application [Kinesis]',
              f.input('print_screen'),
              f.outputKey('grave_accent_and_tilde', ['command']),
              conditions.kinesis_condition,
            ),


            f.rule_1m(
              'Left shift -> Shift+Tab [Kinesis]',
              f.input('left_shift'),
              f.outputKey('tab', ['shift']),
              conditions.kinesis_condition
            ),


            f.rule_1m(
              'Right shift -> Tab [Kinesis]',
              f.input('right_shift'),
              f.outputKey('tab'),
              conditions.kinesis_condition
            ),

            f.rule_1m(
              'Home -> Shift [Kinesis]',
              f.input('home'),
              f.outputKey('left_shift'),
              conditions.kinesis_condition
            ),

            f.rule_1m(
              'PgUp -> Shift [Kinesis]',
              f.input('page_up'),
              f.outputKey('left_shift'),
              conditions.kinesis_condition
            ),


            f.rule_1m(
              'End -> Beginning of line [Kinesis]',
              f.input('end'),
              f.outputKey('left_arrow', ['command']),
              conditions.kinesis_condition
            ),

            f.rule_1m(
              'PgDn -> End of line [Kinesis]',
              f.input('page_down'),
              f.outputKey('right_arrow', ['command']),
              conditions.kinesis_condition
            ),
          ],
        },

        devices: [
          {
            identifiers: devices.kinesis_identifier,
            disable_built_in_keyboard_if_exists: false,
            ignore: false,
            manipulate_caps_lock_led: true,
            fn_function_keys: map_function_keys_to_self,
          },
        ],
      },
      {
        selected: false,
        name: 'Deactivate Karabiner-Elements',
      },
    ],
}
