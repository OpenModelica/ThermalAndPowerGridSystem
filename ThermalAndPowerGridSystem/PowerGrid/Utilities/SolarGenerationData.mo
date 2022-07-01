within ThermalAndPowerGridSystem.PowerGrid.Utilities;

model SolarGenerationData

  extends Icons.SolarGen_Icon;
  import SI = Modelica.Units.SI;
  
  parameter String solarGenerationDataFile = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/CountrySolarGeneration.txt");
  Real hour;
  
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort solarGenerationPower annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds solarGenerationTable(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = solarGenerationDataFile, tableName = "solarGeneration", tableOnFile = true)   annotation(
    Placement(visible = false, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
      
  hour =div(time, 3600);
  solarGenerationTable.u = hour;
  solarGenerationPower.P = solarGenerationTable.y[1] * 1e6;

annotation(
    Icon(graphics = {Text(origin = {0, -120}, extent = {{-100, 10}, {100, -10}}, textString = "%name", fontSize = 10)}));
end SolarGenerationData;
