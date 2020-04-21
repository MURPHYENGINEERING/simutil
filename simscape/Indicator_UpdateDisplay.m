function Indicator_UpdateDisplay(block)
  setup(block);
end

function setup(block)
  block.NumInputPorts  = 2;
  block.NumOutputPorts = 1;

  block.SetPreCompInpPortInfoToDynamic;
  block.SetPreCompOutPortInfoToDynamic;

  %% Inherited
  block.SampleTimes = [-1 0];

  block.SimStateCompliance = 'DefaultSimState';
  block.SetAccelRunOnTLC(true);

  block.RegBlockMethod('Outputs', @Output);
end

function Output(block)
  amps = block.InputPort(1).Data;
  volts = block.InputPort(2).Data;
  
  amps_str = amps;
  volts_str = volts;
 
  mask = get_param(block.BlockHandle,'Parent');
  set_param(mask, 'amps', num2str(double(amps_str)));
  set_param(mask, 'volts', num2str(double(volts_str)));
end