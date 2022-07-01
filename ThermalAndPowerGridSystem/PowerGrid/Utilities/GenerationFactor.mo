within ThermalAndPowerGridSystem.PowerGrid.Utilities;

model GenerationFactor
  
  extends Icons.GenFactor_Icon;
  
  parameter Real Factor "Generation Sensitivity Factor";
  
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort electricalPortIn annotation(
    Placement(visible = true, transformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {-70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort electricalPortOut annotation(
    Placement(visible = true, transformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {70, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

  electricalPortOut.P = electricalPortIn.P * Factor;
  electricalPortOut.V = electricalPortIn.V;

annotation(
    Icon(graphics = {Text(origin = {0, -80}, extent = {{-100, 20}, {100, -20}}, textString = "%name", fontSize = 10)}));
end GenerationFactor;
