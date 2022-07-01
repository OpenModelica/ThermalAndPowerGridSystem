within ThermalAndPowerGridSystem.ThermalGrid.SystemSetup;
record AmbientConditions "Ambient Conditions during simulation period"
  // extends Modelica.Icons.Record;

  import Modelica.Units.SI.Temperature;
  import Modelica.Units.SI.AbsolutePressure;
  
  final constant Temperature TAbs = 273.15;
  parameter AbsolutePressure PAtm = 1.e5;
  parameter Temperature Tambient = 300;
  parameter Temperature Tground = 310;
  
end AmbientConditions;
