local devices = import 'devices.libsonnet';


{
  kinesis_condition: [{
    type: 'device_if',
    identifiers: [devices.kinesis_identifier],
  }],

  apple_condition: [{
    type: 'device_if',
    identifiers: [devices.apple_identifier],
  }],

  layer(name):: [{
    name: 'layer_' + name,
    type: 'variable_if',
    value: 1,
  }],

  unless_finder: {
    type: 'frontmost_application_unless',
    bundle_identifiers: [
      '^com\\.apple\\.finder$',
    ],
  },

  if_finder: {
    type: 'frontmost_application_if',
    bundle_identifiers: [
      '^com\\.apple\\.finder$',
    ],
  },


}
