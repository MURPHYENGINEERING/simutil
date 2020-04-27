function Capacitor_UpdateDisplay(block)
  setup(block);
end

function setup(block)
  block.NumInputPorts  = 1;
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
  mask = get_param(block.BlockHandle,'Parent'); 
  
  capacitance = str2double(get_param(mask, 'capacitance'));
  
  volts = block.InputPort(1).Data;
  charge = capacitance * volts;
  charge_str = num2str(round(charge, 2));
  
  if ~strcmp(get_param(mask, 'charge'), charge_str)
    set_param(mask, 'charge', charge_str);
    set_param(mask, 'volts', num2str(round(volts, 2)));
  end
end