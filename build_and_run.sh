cd hapi && ./download_and_run.sh
cd ..
#after the first time running hapi fhir server it may already be running, if there's an error here can just move
#(although it might create an unused container so maybe better to fix in download script idk)
set -e
cd client && ./generate_fhir.sh && ./compile_and_copy_to_server_static.sh
cd ..
cd server && ./generate_fhir.sh && gleam run -m copy_patients_from_server && gleam run
