class APIPath {
  static String Pump(String uid, String jobID) => 'users/$uid/pumps/$jobID';

  static String Pumps(String uid) => 'users/$uid/pumps';
}
