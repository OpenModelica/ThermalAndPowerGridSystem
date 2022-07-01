within ThermalAndPowerGridSystem.PowerGrid.Utilities;

model WindPowerData

  extends Icons.Wind_Icon;
  import SI = Modelica.Units.SI;
  
  parameter SI.Density airDensity = 1.225 "Air Density (kg/m3)";
  parameter String windSpeedData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/PowerGrid/Resources/CombiTableFiles/WindSpeed.txt");
    
  Real opPower (unit = "W/m2") "Anual Wind Power generated per unit area of the turbine (W/m2)";
  Integer hour;

  Modelica.Blocks.Interfaces.RealOutput windOutputPower annotation(
    Placement(visible = true, transformation(origin = {120, 2.66454e-15}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds windSpeed(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = windSpeedData, tableName = "windSpeed", tableOnFile = true)   annotation(
    Placement(visible = false
, transformation(origin = {4, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

  hour = div(time, 3600);
  windSpeed.u = hour;
  opPower = 0.5 * airDensity *  windSpeed.y[1]^3; 
  windOutputPower = opPower;

annotation(
    Icon(graphics = {Text(origin = {0, -120}, extent = {{-100, 10}, {100, -10}}, textString = "%name", fontSize = 10)}),
    Documentation(info = "<html><head></head><body><!--StartFragment-->Wind data is taken from text file using combi table. It contains hourly wind data for a year.<div><br></div><div>Sample data has been collected from IEEE data set.</div><!--EndFragment--></body></html>"));
end WindPowerData;
