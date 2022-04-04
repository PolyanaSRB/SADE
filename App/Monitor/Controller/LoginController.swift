//
//  LoginController.swift
//  Monitor
//
//  Created by user174461 on 7/5/20.
//  Copyright © 2020 Polyana Barboza. All rights reserved.
//

import UIKit
import Foundation


/// Controller of the login screen
class LoginController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtLogin: UITextField!
    
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.txtLogin.delegate = self
        self.txtPassword.delegate = self

    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    
    @IBAction func signIn(_ sender: Any) {
        print("Entrar")
        
        /// Testing if login exists. If so, collects their general information and which patients are being monitored. After that, initializes the agent with cyclic collector behavior to collect new vital signs from database
        /// it is just a test, ideally it would call in the database
        if (self.txtLogin.text == "natalie@gmail.com" && self.txtPassword.text == "1234") {
            let hcw = COVID19DAOIdentifyHCW.identifyHCW(email: self.txtLogin.text ?? "")!
            COVID19UsefulData.shared.healthCareWorker = hcw
            
            let patients = COVID19DAOGetPatients.getHCWPatients(hcw: hcw)
            COVID19UsefulData.shared.patients = patients
            for patient in patients {
                COVID19DAOPatientVitalSign.getVitalSign(patient: patient, option: "all")
            }
            
            //let b = CollectorAction(interval: 5)
            //CollectorAgent.addBehavior(behavior: b)
            //Environment.environment.start()
            start()
            
            performSegue(withIdentifier: "goToMyPatients", sender: self)
        }
        
        else {
            print("Login não efetuado")
            let alert = UIAlertController(title: "Alerta", message: "Erro no Login/Senha", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
        
    }
    // function to register a new user
    @IBAction func signUp(_ sender: Any) {
        print("Cadastrar")
        performSegue(withIdentifier: "goToCreateAccount", sender: self)
        
    }
    
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        self.txtLogin.text = ""
        self.txtPassword.text = ""
    }
    
    func start() {
        Environment.environment.name = "VSmonitor"

        //set goals
        let collectGoal = Goal(name: "CollectGoal")
        let vitalSignGoal = Goal(name: "VitalSignGoal")
        let alertGoal = Goal(name: "AlertGoal")
        //Environment.environment.goals = [collectGoal, vitalSignGoal, alertGoal]
        
        // set actions
        let collectAction = CollectorAction(interval: 30)
        //var actionsVitalSign: [VitalSignAction] = []
        //var alertAction: [AlertAction] = []
        
        //set plans
        let collectPlan = SequencePlan(name: "CollectPlan", goal: collectGoal)
        collectPlan.actions.append(collectAction)
        let vitalSignPlan = SequencePlan(name: "VitalSignPlan", goal: vitalSignGoal)
        let alertPlan = SequencePlan(name: "AlertPlan", goal: alertGoal)
        
        collectGoal.plans = [0:collectPlan]
        vitalSignGoal.plans = [0:vitalSignPlan]
        alertGoal.plans = [0:alertPlan]

        //set belief revisions
        let collectorBeliefRevision = DefaultBeliefRevisionStrategy()
        let vitalSignBeliefRevision = DefaultBeliefRevisionStrategy()
        let alertBeliefRevision = DefaultBeliefRevisionStrategy()
        
        //set option generations
        let collectorOptionGener = DefaultOptionGenerationStrategy()
        let vitalSignOptionGener = DefaultOptionGenerationStrategy()
        let alertOptionGener = DefaultOptionGenerationStrategy()
        
        //set filter
        let collectorFilter = DefaultDeliberationStrategy()
        let vitalSignFilter = DefaultDeliberationStrategy()
        let alertFilter = DefaultDeliberationStrategy()
        
        //set plan selection
        let collectorPlanSelection = DefaultPlanSelectionStrategy()
        let vitalSignPlanSelection = DefaultPlanSelectionStrategy()
        let alertPlanSelection = DefaultPlanSelectionStrategy()
        
        //set agents
        let collectorAgent = Agent(agentName: "CollectorAgent", goals: [collectGoal], beliefs: [:], plans: [collectPlan], beliefRevision: collectorBeliefRevision, optionGeneration: collectorOptionGener, filter: collectorFilter, planSelection: collectorPlanSelection, port: 9000)
        
        collectAction.agent = collectorAgent
        
        let vitalSignAgent = Agent(agentName: "VitalSignAgent", goals: [vitalSignGoal], beliefs: [:], plans: [vitalSignPlan], beliefRevision: vitalSignBeliefRevision, optionGeneration: vitalSignOptionGener, filter: vitalSignFilter, planSelection: vitalSignPlanSelection, port: 8888)

        let msgtoBeliefCollector = Belief()
        msgtoBeliefCollector.data = vitalSignAgent.agentName
        collectorAgent.addBelief(name: "msgTo", belief: msgtoBeliefCollector)
        
        let alertAgent = Agent(agentName: "AlertAgent", goals: [alertGoal], beliefs: [:], plans: [alertPlan], beliefRevision: alertBeliefRevision, optionGeneration: alertOptionGener, filter: alertFilter, planSelection: alertPlanSelection, port: 9999)
        
        let msgtoBeliefVS = Belief()
        msgtoBeliefVS.data = alertAgent.agentName
        vitalSignAgent.addBelief(name: "msgTo", belief: msgtoBeliefVS)
        
        collectorAgent.start()
        vitalSignAgent.start()
        alertAgent.start()
    }
}
