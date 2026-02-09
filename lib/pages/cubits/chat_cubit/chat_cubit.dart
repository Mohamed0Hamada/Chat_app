import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:folder/pages/cubits/chat_cubit/chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());
}
