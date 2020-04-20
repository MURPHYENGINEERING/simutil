function Probe_UpdateDisplay(block)
  setup(block);
end

function setup(block)
  % Unit parameter
  block.NumDialogPrms  = 1;

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
  value = block.InputPort(1).Data;
  unit = block.DialogPrm(1).Data;
  suffix = '';
  
  if ~strcmpi(unit, 'ohm')
    % Amps or Volts
    value_str = num2str(value);
  else
    % Ohm symbol
    unit = char(hex2dec('03A9'));
    if (value < 0)
      % Probably connected to voltage
      value_str = '?';
    else
      suffixes = ['k', 'M', 'G', 'T', 'P', 'E', 'Z', 'Y'];
      for i = 1:length(suffixes)
        if value < 1000
          break
        end
        value = value / 1000;
        suffix = suffixes(i);
      end
      % Update value string after decimating
      value_str = num2str(value);
    end
  end

  mask_func = [...
    sprintf('fprintf(''%s%s %s'');\n', value_str, suffix, unit) ...
    sprintf('port_label(''lconn'', 1, ''+'');\n') ...
    sprintf('port_label(''rconn'', 1, ''-'');\n') ...
  ];

  set_param(get_param(block.BlockHandle,'Parent'), 'MaskDisplay', mask_func);
end