within ThermalAndPowerGridSystem.PowerGrid.Utilities;

model SolarIrradianceData

  extends Icons.Solar_Icon;
  import SI = Modelica.Units.SI;
  import Modelica.Constants.pi;
  
  parameter String solarIrradianceData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/SolarIrradiance.txt");
  parameter Real pvTiltAngle = 30;
  Real hour;
  
  Modelica.Blocks.Interfaces.RealOutput pvIrradiance annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds pvIrradianceTable(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName = solarIrradianceData, tableName = "pvSolarIrradiance", tableOnFile = true)   annotation(
    Placement(visible = false, transformation(origin = {0, 30}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
equation
      
  hour =div(time, 3600);
  pvIrradianceTable.u = hour;
  pvIrradiance = pvIrradianceTable.y[1]*cos(pi*pvTiltAngle/180);

annotation(
    Diagram,
    Icon(graphics = {Text(origin = {0, -120}, extent = {{-100, 10}, {100, -10}}, textString = "%name", fontSize = 10)}),
  experiment(StartTime = 0, StopTime = 3.1536e+07, Tolerance = 1e-6, Interval = 8760),
  Documentation(info = "<html><head></head><body><!--StartFragment-->This takes solar global&nbsp;<span style=\"font-family: HiraKakuProN-W3, STXihei;\">radiance</span>&nbsp;data form text file using combi table.<span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">&nbsp;It contains hourly horizontal solar radiance data for a year.</span><div><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\"><br></span></div><div><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\">This data is taken from Swedish SMHI (weather institute), Norrköping.</span></div><!--EndFragment--></body></html>"));
end SolarIrradianceData;
