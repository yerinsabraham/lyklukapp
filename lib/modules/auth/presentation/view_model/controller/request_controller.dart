import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lykluk/modules/auth/data/models/signup_req.dart';

import '../../../data/models/login_req.dart';
import '../../../data/models/reset_password_req.dart';

final signUpRequest = StateProvider((_)=> SignUpRequest() );

final loginRequest = StateProvider((_)=> LoginRequest() );

final resetPasswordRequest= StateProvider((_)=> ResetPasswordRequest() );
