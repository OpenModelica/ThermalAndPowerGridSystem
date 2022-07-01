within ThermalAndPowerGridSystem.PowerGrid.Interfaces;

connector ElectricalPort " Electrical power connector"

  flow Modelica.Units.SI.Power P "Power transmitted into the connector";
  
  Modelica.Units.SI.Voltage V "Connector voltage (dummy Variable)"; 
  
  annotation(
    Icon(graphics = {Rectangle(origin = {0.18, 0.1}, fillColor = {199, 200, 201}, fillPattern = FillPattern.Sphere, extent = {{-100.04, 99.85}, {100.04, -99.85}}, radius = 50), Text(lineColor = {255, 255, 255}, extent = {{-100, 100}, {100, -100}}, textString = "E")}),
    Documentation(info = "<html><head></head><body><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\">Electrical power port which contains two variables Power as flow variable and Voltage as potential variable.</span></body></html>"));
end ElectricalPort;
