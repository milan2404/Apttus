List<String> listObjectName = new List<String>(Schema.getGlobalDescribe().keyset());
System.debug(LoggingLevel.Error, 'MSA All Objects: CustomObject:'+ String.join(listObjectName,',CustomObject:'));
