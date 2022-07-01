within ThermalAndPowerGridSystem.ThermalGrid.SystemSetup;

model SystemFluid "Properties of medium"
  //extends Modelica.Icons.MaterialProperty;
   replaceable package FluidWater = Modelica.Media.Water.ConstantPropertyLiquidWater constrainedby Modelica.Media.Interfaces.PartialMedium annotation(choicesAllMatching = true); 
   replaceable package FluidMedium = Modelica.Media.Water.StandardWater constrainedby Modelica.Media.Interfaces.PartialMedium annotation(
     choicesAllMatching = true);   
end SystemFluid;
