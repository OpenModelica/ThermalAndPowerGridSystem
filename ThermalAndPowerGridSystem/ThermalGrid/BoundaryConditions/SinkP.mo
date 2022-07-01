within ThermalAndPowerGridSystem.ThermalGrid.BoundaryConditions;

model SinkP "Sink boundary condition with Pressure specified"
  import Modelica.Units.SI.AbsolutePressure;
  
  parameter AbsolutePressure P = 1.2e5;
  
  ThermalAndPowerGridSystem.ThermalGrid.Interfaces.WaterPort port annotation(
    Placement(visible = true, transformation(origin = {-52, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-50, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
  port.pressure = P;
  port.specificEnthalpy = 0;
  annotation(
    Diagram(graphics = {Ellipse(origin = {1, -3}, fillColor = {208, 144, 240}, fillPattern = FillPattern.Sphere, extent = {{-43, 43}, {43, -43}}, endAngle = 360), Text(origin = {1, -3}, extent = {{-19, 11}, {19, -11}}, textString = "Sink")}),
    Icon(graphics = {Ellipse(origin = {1, -3}, fillColor = {208, 144, 240}, fillPattern = FillPattern.Sphere, extent = {{-43, 43}, {43, -43}}, endAngle = 360), Text(origin = {1, -3}, extent = {{-19, 11}, {19, -11}}, textString = "Sink")}));
end SinkP;
