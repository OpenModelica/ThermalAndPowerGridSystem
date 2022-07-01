within ThermalAndPowerGridSystem.PowerGrid.Components;

model SolarFarm

  extends Icons.PVcell_Icon;
  
  import SI = Modelica.Units.SI;

  SI.Power solarPower "Solar Power from Sun(W)";
  SI.Power solarElectricalPower "Generated Electrical Power (W)";
  
  parameter SI.Efficiency PvGenerationEfficiency = 0.4 "PV Panel Electrical Power Generation Efficiency";
  parameter SI.Area pvSurfaceArea = 2 " PV Panels Cumulative Surface Area (m2)";
  parameter Real numberofPvPanels = 1000;
  
  Modelica.Blocks.Interfaces.RealInput solarIrradiance (unit = "W/m2") annotation(
    Placement(visible = true, transformation(origin = {-100, 0}, extent = {{-20, -20}, {20, 20}}, rotation = 0), iconTransformation(origin = {-110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  ThermalAndPowerGridSystem.PowerGrid.Interfaces.ElectricalPort electricalPort annotation(
    Placement(visible = true, transformation(origin = {90, -2}, extent = {{-10, -10}, {10, 10}}, rotation = 0), iconTransformation(origin = {110, 0}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));

equation

  solarPower = solarIrradiance * pvSurfaceArea * numberofPvPanels;
  solarElectricalPower = solarPower * PvGenerationEfficiency;
  electricalPort.P = - solarElectricalPower;

annotation(
    Icon(graphics = {Text(origin = {0, -125}, extent = {{-100, 15}, {100, -15}}, textString = "%name", fontSize = 10)}),
    Documentation(info = "<html><head></head><body><!--StartFragment--><span style=\"font-size: 12px; font-family: 'DejaVu Sans Mono';\">This component is model of solar farm, where pv panels are installed on roof (for single house) and pv panels are in solar farm (for multiple house).</span><div><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\"><br></span></div><div><span style=\"font-family: 'DejaVu Sans Mono'; font-size: 12px;\">Equation used for electrical power generation fron solar radiance ia as product of&nbsp;</span><i><span style=\"font-family: 'DejaVu Sans Mono';\">solar radiance,&nbsp;</span><span style=\"font-family: 'DejaVu Sans Mono';\">pv surface area, number of pv panel and pv generation efficiency.</span></i></div><!--EndFragment--></body></html>"));
end SolarFarm;
