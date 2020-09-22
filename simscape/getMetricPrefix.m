function [magnitude, prefix] = getMetricPrefix(num)
  prefixes = ['y' 'z' 'a' 'f' 'p' 'n' char(181) 'm' ' ' 'k' 'M' 'G' 'T' 'P' 'E' 'Z' 'Y'];
  index = 9;
  while (index < length(prefixes) && abs(num) >= 1000)
    num = num / 1000;
    index = index + 1;
  end
  while (index > 1 && abs(num) <= 0.1)
    num = num * 1000;
    index = index - 1;
  end
  magnitude = num;
  prefix = strtrim(prefixes(index));
end