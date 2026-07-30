let
    Origem = Csv.Document(File.Contents("C:\Users\Marcia\Downloads\ANALISTA DE DADOS\People-Analytics-Workforce-Intelligence\00_Dataset_Original\leave_requests.csv"),[Delimiter=",", Encoding=65001, QuoteStyle=QuoteStyle.None]),
    #"Cabeçalhos promovidos" = Table.PromoteHeaders(Origem, [PromoteAllScalars = true]),
    #"Tipos Ajustados" = Table.TransformColumnTypes(#"Cabeçalhos promovidos",{
        {"employee_id", Int64.Type},
        {"request_date", type date},
        {"leave_type", type text},
        {"approval_status", type text},
        {"absence_code", type text}
    })
in
    #"Tipos Ajustados"
