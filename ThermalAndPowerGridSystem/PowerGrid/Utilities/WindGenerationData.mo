within ThermalAndPowerGridSystem.PowerGrid.Utilities;

model WindGenerationData

  extends Icons.WindGen_Icon;
  
  parameter String windGenerationDataFile = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/CountryWindGeneration.txt");
  Real hour;
  
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort windGenerationPower annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {90, -50}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds windGenerationTable(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = windGenerationDataFile, tableName = "windGeneration", tableOnFile = true)   annotation(
    Placement(visible = false, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
      
  hour =div(time, 3600);
  windGenerationTable.u = hour;
  windGenerationPower.P = windGenerationTable.y[1] * 1e6;

annotation(
    Icon(graphics = {Text(origin = {0, -120}, extent = {{-100, 10}, {100, -10}}, textString = "%name", fontSize = 10)}));
end WindGenerationData;
