
class Actors {
  
   List<Actor> listActors = new List();

  Actors();

  Actors.formJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    for (var item in jsonList) {
      final actor = new Actor.fromJsonMap(item);
      listActors.add(actor);
    }
  }
}


class Actor {
  int actorId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.actorId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });


  Actor.fromJsonMap(Map<String,dynamic> jsonActor){
   
    actorId = jsonActor['actor_id'];
    character = jsonActor['character'];
    creditId = jsonActor['credit_id'];
    gender = jsonActor['gender'];
    id =  jsonActor['id'];
    name = jsonActor['name'];
    order = jsonActor['order'];
    profilePath = jsonActor['profile_path'];



  }


  
  getImgProfileActor() {
    if (profilePath == null) {
      return 'https://cdn.clipart.email/9456a5d596eb572cfa9d755e02597632_silhouette-grey-man-300-aret-learning-trust_300-400.jpeg';
    } else {
      return 'https://image.tmdb.org/t/p/w500/$profilePath';
    }
  }
}


