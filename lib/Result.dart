class Result {
  String? key;
  String? url;
  String? description;
  String? image;
  String? name;
  String? source;
  String? title;

  Result(
      {this.key,
        this.url,
        this.description,
        this.image,
        this.name,
        this.source,
        this.title
      });

  Result.fromJson(Map<String, dynamic> json) {
    key = json['key'];
    url = json['url'];
    description = json['description'];
    image = json['image'];
    name = json['name'];
    source = json['source'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['key'] = this.key;
    data['url'] = this.url;
    data['description'] = this.description;
    data['image'] = this.image;
    data['name'] = this.name;
    data['source'] = this.source;
    data['title'] = this.title;
    return data;
  }
}