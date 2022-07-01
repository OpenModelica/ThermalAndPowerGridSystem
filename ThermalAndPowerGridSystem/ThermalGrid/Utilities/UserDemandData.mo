within ThermalAndPowerGridSystem.ThermalGrid.Utilities;

model UserDemandData "Accesses Solar Irradiation data from text file and converts to combitable1Ds format"
  extends ThermalAndPowerGridSystem.ThermalGrid.Icons.userDemand;
  import SI = Modelica.Units.SI;
  
  parameter String userDemandData = Modelica.Utilities.Files.loadResource("modelica://ThermalAndPowerGridSystem/Resources/CombiTableFiles/CountryHeatDemand.txt");
 
  Real hour;
  
  Modelica.Blocks.Interfaces.RealOutput userDemand annotation(
    Placement(visible = true, transformation(origin = {120, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  Modelica.Blocks.Tables.CombiTable1Ds userDemandTable(extrapolation = Modelica.Blocks.Types.Extrapolation.NoExtrapolation, fileName =userDemandData, tableName = "heatDemand", tableOnFile = true)   annotation(
    Placement(visible = false, transformation(origin = {4, 2}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation
      
  hour =div(time, 3600);
  userDemandTable.u = hour;
  userDemand = userDemandTable.y[1];
annotation(
    Documentation(info = "<html><head></head><body>The python program file.py in the Resources folder can be accessed to extract the required solar irradiation data from excel into a text file. This text file is then input into this model to provide Direct Solar Irradiation data for solar CSP model.</body></html>"));
end UserDemandData;
