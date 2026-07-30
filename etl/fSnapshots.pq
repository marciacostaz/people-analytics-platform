let
    Origem = Csv.Document(File.Contents("C:\Users\Marcia\Downloads\ANALISTA DE DADOS\People-Analytics-Workforce-Intelligence\00_Dataset_Original\snapshots_updated.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos promovidos" = Table.PromoteHeaders(Origem, [PromoteAllScalars = true]),
    #"Colunas Removidas" = Table.RemoveColumns(#"Cabeçalhos promovidos",{"manager_id", "last_promotion_date"}),
    #"Tipos Texto Data" = Table.TransformColumnTypes(#"Colunas Removidas",{
        {"employee_id", Int64.Type},
        {"snapshot_date", type date},
        {"tenure_months", Int64.Type},
        {"job_level", Int64.Type},
        {"age", Int64.Type},
        {"high_potential_flag", type logical},
        {"hire_date", type date},
        {"termination_date", type date},
        {"birth_date", type date},
        {"last_training_date", type date}
    }),
    #"Tipos Decimais" = Table.TransformColumnTypes(#"Tipos Texto Data",{
        {"current_salary", type number},
        {"base_salary", type number},
        {"performance_rating", type number},
        {"engagement_score", type number},
        {"risk_of_exit_score", type number},
        {"fte", type number},
        {"bonus_pct", type number},
        {"equity_pct", type number}
    }, "en-US"),
    #"Faixa Tempo Casa" = Table.AddColumn(#"Tipos Decimais", "faixa_tempo_casa", each
        if [tenure_months] <= 3 then "0-3 meses"
        else if [tenure_months] <= 12 then "4-12 meses"
        else if [tenure_months] <= 36 then "1-3 anos"
        else "3+ anos", type text),
    #"Ordem Faixa" = Table.AddColumn(#"Faixa Tempo Casa", "ordem_faixa", each
        if [tenure_months] <= 3 then 1
        else if [tenure_months] <= 12 then 2
        else if [tenure_months] <= 36 then 3
        else 4, Int64.Type)
in
    #"Ordem Faixa"