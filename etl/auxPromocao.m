let
    Origem = fSnapshots,
    #"Colunas Mantidas" = Table.SelectColumns(Origem,{"employee_id", "job_level"}),
    #"Agrupado" = Table.Group(#"Colunas Mantidas", {"employee_id"}, {
        {"nivel_min", each List.Min([job_level]), Int64.Type},
        {"nivel_max", each List.Max([job_level]), Int64.Type}
    }),
    #"Flag Promocao" = Table.AddColumn(#"Agrupado", "foi_promovido", each [nivel_max] > [nivel_min], type logical),
    #"Degraus" = Table.AddColumn(#"Flag Promocao", "degraus_promocao", each [nivel_max] - [nivel_min], Int64.Type),
    #"Colunas Finais" = Table.SelectColumns(#"Degraus",{"employee_id", "foi_promovido", "degraus_promocao"})
in
    #"Colunas Finais"



