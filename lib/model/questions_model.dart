class QuestionModel {

  List<QuestionDataModel>? data;

  QuestionModel({   this.data});

  QuestionModel.fromJson(Map<String, dynamic> json) {

    if (json['data'] != null) {
      data = <QuestionDataModel>[];
      json['data'].forEach((v) {
        data!.add(new QuestionDataModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class QuestionDataModel {

  String? question;
  int? questionMark;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  String? correctAnswer;


  QuestionDataModel(
      {
        this.question,
        this.questionMark,
        this.answer1,
        this.answer2,
        this.answer3,
        this.answer4,
        this.correctAnswer,
     });

  factory QuestionDataModel.fromJson(  json) {
    return QuestionDataModel(

      question: json['question'],
      questionMark: json['question_mark'],
      answer1: json['answer_1'],
      answer2: json['answer_2'],
      answer3: json['answer_3'],
      answer4: json['answer_4'],
      correctAnswer: json['correct_answer'],

    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['question'] = this.question;
    data['question_mark'] = this.questionMark;
    data['answer_1'] = this.answer1;
    data['answer_2'] = this.answer2;
    data['answer_3'] = this.answer3;
    data['answer_4'] = this.answer4;
    data['correct_answer'] = this.correctAnswer;

    return data;
  }
}
