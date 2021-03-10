#seed data for testing associations

#creating two users:
jessie = User.create(username: "Jessie", email: "jessie@jessie.com", password: "password")
katie = User.create(username: "Katie", email: "katie@katie.com", password: "password")

#creating some yarns:
Yarn.create(name: "LolaBean", color: "Olive Green", weight: "DK", fiber: "Wool", user_id: katie.id)
Yarn.create(name: "NFC", color: "Gray", weight: "Fingering", fiber: "Wool Blend", user_id: jessie.id)

#use activerecord to pre-associate data:
jessie.yarns.create(name: "Vale", color: "Dark Purple", weight: "Lace", fiber: "Wool")

katies_entry = katie.yarns.build(name: "KnitPicks", color: "Lime Green", weight: "Fingering", fiber: "Wool Blend")
katies_entry.save