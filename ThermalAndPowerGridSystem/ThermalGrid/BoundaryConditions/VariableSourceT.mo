within ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions;

model VariableSourceT
  //parameter Modelica.SIunits.Temp_K hotWaterTemperature;
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.tempConnector tempOut annotation(
    Placement(visible = true, transformation(origin = {4, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {4, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Interfaces.RealInput hotTemperature annotation(
    Placement(visible = true, transformation(origin = {-110, 24}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-94, 34}, extent = {{-20, -20}, {20, 20}}, rotation = 0)));
equation

 tempOut.temp = -hotTemperature;
 
       
annotation(
    Icon(graphics = {Ellipse(origin = {4, -1}, lineThickness = 10.5, extent = {{-34, 35}, {34, -35}}, endAngle = 360)}),
    Documentation(info = "<html><head></head><body>Used for the modeling of Stratified Tanks</body></html>"));
end VariableSourceT;
