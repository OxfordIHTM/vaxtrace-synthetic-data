#'
#' Create form 2 output type specification
#' 

llm_create_form2_type <- function() {
  ellmer::type_array(
    ellmer::type_object(
      "Specification of expected data structure for form 2 synthetic data",
      date = ellmer::type_string(
        description = "The date when the adverse effect was entered on the form. Format: YYYY-MM-DD.",
        required = TRUE
      ),
      client_id = ellmer::type_string(
        description = "Unique identifier for the client.", required = TRUE
      ),
      full_name = ellmer::type_string(
        description = "Full name of the client.", required = TRUE
      ),
      sex = ellmer::type_enum(
        values = c("male", "female"),
        description = "Sex of the client", required = TRUE
      ),
      date_of_birth = ellmer::type_string(
        description = "Date of birth of the client. Format: YYYY-MM-DD.",
        required = TRUE
      ),
      address = ellmer::type_string(
        description = "Address of the client.", required = TRUE
      ),
      vaccine_trade_name = ellmer::type_enum(
        values = c(
          "Bacille Calmette-Guérin", "Engerix-B", "Recombivax HB", "Comvax",
          "IPV", "OPV", "DTaP", "Tdap", "Hiberix", "ActHIB", "MMR", "Priorix-Tetra",
          "Ixiaro", "RotaTeq", "Rotarix", "Prevnar 13", "Pneumovax 23", "Gardasil",
          "Cervarix", "Fluzone", "FluMist", "Zostavax", "Varivax", "Havrix",
          "Vaqta", "Typhim Vi", "Vivotif", "Menactra", "Menomune-A/C/Y/W-135",
          "Nimenrix", "Comirnaty", "Spikevax", "Jcovden"
        ),
        description = "Trade name of the vaccine administered to the patient.",
        required = TRUE
      ),
      lot_number = ellmer::type_string(
        description = "Lot number for the vaccine administered to the patient.",
        required = TRUE
      ),
      expiry_date = ellmer::type_string(
        description = "Expiry date for the vaccine administered to the patient in YYYY-MM-DD format.",
        required = TRUE
      ),
      vaccination_date_time = ellmer::type_string(
        description = "Date and time when the vaccine was administered to the client in YYYY-MM-DD HH:MM format.",
        required = TRUE
      ),
      injection_site = ellmer::type_enum(
        values = c("left arm", "right arm", "left thigh", "right thigh"),
        description = "Site of injection for the vaccine administered to the patient.",
        required = TRUE
      ),
      date_time_event = ellmer::type_string(
        description = "Date and time when the adverse event occurred in YYYY-MM-DD HH:MM format.",
        required = TRUE
      ),
      symptoms = ellmer::type_string(
        description = "Symptoms experienced by the patient.",
        required = TRUE
      ),
      management = ellmer::type_string(
        description = "Management of the adverse event.",
        required = TRUE
      ),
      outcome = ellmer::type_string(
        description = "Outcome of the adverse event.",
        required = TRUE
      ),
      notes = ellmer::type_string(
        description = "Any additional notes about the patient's condition or treatment.",
        required = FALSE
      )
    )
  )
}
