-- Scenario Rive Brisee — INCREMENT 2 : lier l InstanceScript a la map 1460.
-- (Applique par maint_deploy_bshore.sh lors du deploiement du binaire avec le script C++.)
UPDATE instance_template SET script = "instance_broken_shore" WHERE map = 1460;
