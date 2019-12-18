SELECT [dbo].Document.Message,
       dbo.Message.ID,
       dbo.[Document].Format,
       dbo.Format.Name      AS FormatName,
       dbo.System.Name,
       dbo.WorkOrderNumber.WorkOrderNumber,
       dbo.Message.EnvelopeID,
       dbo.Message.[From],
       MessageFrom.Name     AS FromName,
       dbo.Message.Timestamp,
       dbo.Message.Type,
       dbo.Type.Name        AS TypeName,
       dbo.Message.SubType,
       dbo.SubType.Name     AS SubTypeName,
       dbo.Message.ChangeType,
       dbo.ChangeType.Name  AS ChangeTypeName,
       dbo.Message.MessageType,
       dbo.MessageType.Name AS MessageTypeName,
       dbo.Message.SubSubType,
       dbo.SubSubType.Name  AS SubSubTypeName
FROM dbo.[Document]
         INNER JOIN dbo.Format ON dbo.[Document].Format = dbo.Format.ID
         RIGHT OUTER JOIN dbo.Message ON dbo.[Document].MessageId = dbo.Message.ID
         LEFT OUTER JOIN dbo.System AS MessageFrom ON dbo.Message.[From] = MessageFrom.ID
         LEFT OUTER JOIN dbo.Type ON dbo.Message.Type = dbo.Type.ID
         LEFT OUTER JOIN dbo.SubType ON dbo.Message.SubType = dbo.SubType.ID
         LEFT OUTER JOIN dbo.ChangeType ON dbo.Message.ChangeType = dbo.ChangeType.ID
         LEFT OUTER JOIN dbo.MessageType ON dbo.Message.MessageType = dbo.MessageType.ID
         LEFT OUTER JOIN dbo.SubSubType ON dbo.Message.SubSubType = dbo.SubSubType.ID
         LEFT OUTER JOIN dbo.WorkOrder ON dbo.Message.WorkOrderID = dbo.WorkOrder.ID
         LEFT OUTER JOIN dbo.System ON dbo.WorkOrder.System = dbo.System.ID
         INNER JOIN dbo.WorkOrderNumber ON dbo.WorkOrder.ID = dbo.WorkOrderNumber.WorkOrder AND
                                           dbo.WorkOrder.System = dbo.WorkOrderNumber.System

where WorkOrderNumber = '19201207-PATT'
order by Timestamp asc