class Endpoints {
  static final Endpoints _endPoints = Endpoints._internal();

  factory Endpoints() {
    return _endPoints;
  }

  Endpoints._internal();

  // mps
  String mpOfTheWeek = "/mp/";
  String allMpsEndpoint = "/mp/all";

  // Events
  String allEventsEndpoint = "/events/";

  // Participations
  String allParticipationsEndpoint = "/participation/";
  String allResponsesOfParti(String participationId) {
    return "/participation/response/$participationId ";
  }

  String addResponseEndpoint = "/participation/response/add";
  String deleteResponseEndpoint(String reponseId) {
    return "/participation/response/delete/$reponseId";
  }

  // Users
  String signInEndpoint = "/auth/sign_in";
  String signUpEndpoint = "/auth/sign_up";
}
