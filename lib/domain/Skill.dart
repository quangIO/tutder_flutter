class Skill {
  final String name;
  final String level;

  Skill(this.name, [this.level = "STRONG"]);

  Map<String, String> toMap() => {'name': name, 'level': this.level};
}
