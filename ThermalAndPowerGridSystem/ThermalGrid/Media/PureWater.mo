within ThermalAndPowerGridSystem.ThermalGrid.Media;

record PureWater
  //PureComponentFluid water(redeclare package Medium= Modelica.Media.Water.StandardWater);
   import SpecificHeat=Modelica.Units.SI.SpecificHeatCapacity; 
   import Density = Modelica.Units.SI.Density; 
   import AbsoluteTemperature = Modelica.Units.SI.Temperature;
   
   parameter SpecificHeat cp_const=4184 "J/kgK";
   parameter Density d_const=995.586 "kg/m3";
   parameter AbsoluteTemperature DatumTemperature =273.15 "K";
end PureWater;
