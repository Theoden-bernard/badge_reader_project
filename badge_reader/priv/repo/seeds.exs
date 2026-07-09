# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     BadgeReader.Repo.insert!(%BadgeReader.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias BadgeReader.Repo
alias BadgeReader.{Accounts, AccessPointsManager, RoleManager, BadgeManager}
alias BadgeReader.Accounts.User
alias BadgeReader.RoleManager.Role
alias BadgeReader.BadgeManager.Badge
alias BadgeReader.Logs.Log
alias BadgeReader.AccessPointsManager.AccessPoints

# ==========================================
# STEPS 1 : Nettoyage de la DB (Ordre inverse des clés étrangères)
# ==========================================
IO.puts("Nettoyage de la base de données...")
Repo.delete_all(Log)
Repo.delete_all(Badge)
Repo.delete_all(User)
Repo.delete_all(Role)
Repo.delete_all(AccessPoints)

# ==========================================
# STEPS 2 : Create Roles
# ==========================================
IO.puts("Creation de Roles")
{:ok, administrateur} = RoleManager.create_role(%{name_role: "Administrateur"})
{:ok, etudiant} = RoleManager.create_role(%{name_role: "Etudiant"})
{:ok, staff} = RoleManager.create_role(%{name_role: "Staff"})

# ==========================================
# STEPS 3 : creation of Users and Creation to Badges
# ==========================================
admin_password = System.get_env("PASSWORD_ADMIN", "password1234")

IO.puts("Création des utilisateurs de test...")

{:ok, admin} =
  Accounts.admin_create_user(%{
    firstname: "Théoden",
    lastname: "Bernard",
    email: "tb@colint.school",
    password: admin_password,
    role_id: administrateur.id
  })

{:ok, _badge_admin} =
  BadgeManager.create_badge(%{
    rfid: 1,
    name_badge: "badge_admin",
    date_activation: DateTime.utc_now(),
    date_expiration: DateTime.add(DateTime.utc_now(), 20),
    status: true,
    user_id: admin.id
  })

Enum.each(1..20, fn i ->
  {:ok, user_etudiant} =
    Accounts.admin_create_user(%{
      firstname: Faker.Person.first_name(),
      lastname: Faker.Person.last_name(),
      email: "etudiant#{i}@example.com",
      password: "MdpEtudiantFixe123!",
      role_id: etudiant.id
    })

  {:ok, _badge_etudiant} =
    BadgeManager.create_badge(%{
      rfid: "2#{i}",
      name_badge: "badge_etudiant#{i}",
      date_activation: DateTime.utc_now(),
      date_expiration: DateTime.add(DateTime.utc_now(), 20),
      status: true,
      user_id: user_etudiant.id
    })
end)

Enum.each(1..10, fn i ->
  {:ok, user_staff} =
    Accounts.admin_create_user(%{
      firstname: Faker.Person.first_name(),
      lastname: Faker.Person.last_name(),
      email: "staff#{i}@example.com",
      password: "MdpStaffFixe123!",
      role_id: staff.id
    })

  {:ok, _badge_staff} =
    BadgeManager.create_badge(%{
      rfid: "3#{i}",
      name_badge: "badge_staff#{i}",
      date_activation: DateTime.utc_now(),
      date_expiration: DateTime.add(DateTime.utc_now(), 20),
      status: true,
      user_id: user_staff.id
    })
end)

# ==========================================
# STEPS 5 : Creation to Access points
# ==========================================
IO.puts("Création des access points")

AccessPointsManager.create_access_point(%{name_access_points: "Batiment", places: "Acceuil"}, [
  BadgeReader.RoleManager.get_role_by_name("Administrateur").id,
  BadgeReader.RoleManager.get_role_by_name("Etudiant").id,
  BadgeReader.RoleManager.get_role_by_name("Staff").id
])

AccessPointsManager.create_access_point(%{name_access_points: "Pointeuse", places: "Acceuil"}, [
  BadgeReader.RoleManager.get_role_by_name("Administrateur").id,
  BadgeReader.RoleManager.get_role_by_name("Etudiant").id,
  BadgeReader.RoleManager.get_role_by_name("Staff").id
])

IO.puts("Base de données initialisée avec succès")
