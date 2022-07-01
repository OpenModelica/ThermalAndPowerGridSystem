within ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions;

model SinkT

  Modelica.Units.SI.Temperature coldWaterTemperature;
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.tempConnector tempIn annotation(
    Placement(visible = true, transformation(origin = {4, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {4, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
tempIn.temp = coldWaterTemperature;
annotation(
    Icon(graphics = {Ellipse(origin = {4, -1}, lineThickness = 10.5, extent = {{-34, 35}, {34, -35}}, endAngle = 360)}),
    Documentation(info = "<html><head></head><body>Used for the modeling of Stratified Tanks</body></html>"));
end SinkT;
