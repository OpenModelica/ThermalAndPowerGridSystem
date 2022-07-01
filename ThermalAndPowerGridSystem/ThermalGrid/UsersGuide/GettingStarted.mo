within ThermalAndPowerGridSystem.ThermalGrid.UsersGuide;

class GettingStarted
 extends Modelica.Icons.Information;
 
  annotation (Documentation(info = "<html><head></head><body><br><div> <p>Please Explore <a href=\"modelica://ThermalAndPowerGridSystem.ThermalGrid.TestExamples.ScenariosRealData.SimulationScenarios\">Simulation Scenarios </a>and other examples under <b>Test Examples.&nbsp;</b></p></div><div><ul><li>Each scenario has three models. The scenario and the control are decoupled into two models. A third model connects the scenario and its control. This is the model which is to be simulated.</li><li>The parameters for each scenario may be changed by double cicking on individual components.</li><li>To input different hourly data, run the pyhton file \"DataExtractionScript.py\"<b>&nbsp;</b>under <b>Resources folder</b> of the main package. This will generate the corresponding text files.</li><li>Accordingly set mass flow rate of water and the volume of tanks.&nbsp;</li><li>To change the heat demand, double click on the consumption models, i.e, domestic or industrial models.&nbsp;</li></ul></div><div><p><br></p></div></body></html>"));
end GettingStarted;
