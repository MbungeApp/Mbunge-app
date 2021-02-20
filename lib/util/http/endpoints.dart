class Endpoints {
  static final Endpoints _endPoints = Endpoints._internal();

  factory Endpoints() {
    return _endPoints;
  }

  Endpoints._internal();

  // Webinars
  String allWebinars = "/webinar/";
  String allResponsesOfParti(String participationId) {
    return "/webinar/response/$participationId";
  }

  String webinarStatus(String id) {
    return "/webinar/status/$id";
  }

  String addResponseEndpoint = "/webinar/response/add";
  String deleteResponseEndpoint(String reponseId) {
    return "/webinar/response/delete/$reponseId";
  }

  // mps
  String mpOfTheWeek = "/mp/";
  String allMpsEndpoint = "/mp/all";

  // Events
  String allEventsEndpoint = "/events/";

  // Users
  String signInEndpoint = "/auth/sign_in";
  String signUpEndpoint = "/auth/sign_up";
}
