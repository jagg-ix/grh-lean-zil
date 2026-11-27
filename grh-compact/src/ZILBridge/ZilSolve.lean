import Lean.Elab.Tactic
import ZILBridge.ZilChecked
namespace Zil.Datalog
macro "zil_solve" : tactic => `(tactic| exact holds_of_checked (by native_decide))
macro "zil_refute" : tactic => `(tactic| exact not_holds_of_checked (by native_decide))
end Zil.Datalog
