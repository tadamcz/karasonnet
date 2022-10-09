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
}
