within ThermalAndPowerGridSystem.ThermalGrid.Media;

model PureComponentFluid
  //replaceable package Medium = Modelica.Media.Interfaces.PartialPureSubstance;
  package Medium = Modelica.Media.Water.StandardWater;
  //Media.PureComponentFluid C(redeclare package Medium = Modelica.Media.Water.StandardWater);
  
  import AbsoluteTemperature = Modelica.Units.SI.Temperature;
  import AbsolutePressure = Modelica.Units.SI.AbsolutePressure;
  import Modelica.Units.SI.Area;
  import Modelica.Units.SI.Volume;
  import Modelica.Units.SI.Height;
  import HTC = Modelica.Units.SI.CoefficientOfHeatTransfer;
  import Modelica.Units.SI.Energy;
  import DeltaP =Modelica.Units.SI.PressureDifference;
  import Modelica.Units.SI.MassFlowRate;
  import Modelica.Units.SI.SpecificEnthalpy;
  import Modelica.Units.SI.Density;
  
  Modelica.Media.Water.StandardWater.ThermodynamicState state;
  //Modelica.Media.Water.StandardWater.SpecificEnthalpy specificEnthalpy;
  //Modelica.Media.Water.StandardWater.Density density;
  //Modelica.Media.Water.StandardWater.AbsolutePressure P;
  //Modelica.Media.Water.StandardWater.Temperature T; 
  Density density;
  SpecificEnthalpy specificEnthalpy;
  AbsolutePressure P;
  AbsoluteTemperature T; 
  
  
  parameter Real PValue = 1e5;
  parameter Real TValue= 300;

equation
  P = PValue;
  T = TValue;
  state = Medium.setState_pT(P, T);
  specificEnthalpy = Medium.specificEnthalpy(state);
  density = Medium.density(state);
end PureComponentFluid;
