within ThermalAndPowerGridSystem.ThermalGrid.Interfaces;

connector tempConnector "Temperature Connector "
  flow Modelica.Units.SI.Temperature temp;
 annotation(
    Diagram(graphics = {Ellipse(origin = {1, -1}, fillColor = {20, 206, 248}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-31, 31}, {31, -31}}, endAngle = 360)}),
    Icon(graphics = {Ellipse(origin = {1, -1}, fillColor = {20, 206, 248}, pattern = LinePattern.None, fillPattern = FillPattern.Solid, lineThickness = 1, extent = {{-31, 31}, {31, -31}}, endAngle = 360)}));
end tempConnector;
