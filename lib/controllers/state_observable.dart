import 'package:criando_gerenciamento_estado/contracts/observable_state.dart';
import 'package:criando_gerenciamento_estado/controllers/change_state.dart';

class StateObservable<T> extends ChangeState implements ObservableState {
  T _state;

  @override
  T get state => _state;

  set state(T newState) {
    if (_state != newState) {
      _state = newState;
      notifyCallbacks();
    }
  }

  StateObservable(this._state);
}
