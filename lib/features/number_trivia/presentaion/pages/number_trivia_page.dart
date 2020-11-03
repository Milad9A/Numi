import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:numi_clean_tdd/features/number_trivia/presentaion/widgets/loading_widget.dart';
import 'package:numi_clean_tdd/features/number_trivia/presentaion/widgets/message_display.dart';
import 'package:numi_clean_tdd/features/number_trivia/presentaion/widgets/trivia_controls.dart';
import 'package:numi_clean_tdd/features/number_trivia/presentaion/widgets/trivia_display.dart';

import '../../../../injection_container.dart';
import '../bloc/number_trivia_bloc.dart';

class NumberTriviaPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Trivia'),
      ),
      body: SingleChildScrollView(
        child: buildBody(context),
      ),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBody(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10.0),
              // Top Half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                builder: (context, state) {
                  if (state is Empty) {
                    return MessageDisplay(
                      message: 'Start Searching',
                    );
                  } else if (state is Loading) {
                    return LoadingWidget();
                  } else if (state is Loaded) {
                    return TriviaDisplay(numberTrivia: state.trivia);
                  } else if (state is Error) {
                    return MessageDisplay(message: state.message);
                  }
                },
              ),

              SizedBox(height: 20.0),

              // Bottom Half
              TriviaControls(),
            ],
          ),
        ),
      ),
    );
  }
}
