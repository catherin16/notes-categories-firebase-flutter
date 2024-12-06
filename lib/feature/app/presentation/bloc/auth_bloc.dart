import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/feature/data/models/auth_model.dart';
import 'package:notes_app/feature/domain/entities/auth_entity.dart';
import 'auth_event.dart';
import 'auth_state.dart';


class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthBloc() : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _auth.signInWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );
        emit(AuthAuthenticated(userCredential.user!));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<RegisterEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final userCredential = await _auth.createUserWithEmailAndPassword(
          email: event.email,
          password: event.password,
        );

        // Almacenar el nombre y el correo en Firestore
        final userModel = UserModel(
          name: event.name,
          email: event.email,
          password: event.password,
        );
        await _firestore
            .collection('users')
            .doc(userCredential.user!.uid)
            .set(userModel.toJson());

        emit(AuthAuthenticated(userCredential.user!));


      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      await _auth.signOut();
      emit(AuthLoggedOut());
    });
  }
}
