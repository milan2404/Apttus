public with sharing abstract class Constants {
    public static SOQL SOQL {
        get {
            if (SOQL == null) {
                SOQL = new SOQL();
            }
            return SOQL;
        }
        private set;
    }

    public class SOQL {
        public final Integer RowLimit = Limits.getLimitQueryRows();
    }
    public static TaxBreakupType TaxBreakupType {
        get {
            if (TaxBreakupType == null) {
                TaxBreakupType = new TaxBreakupType();
            }
            return TaxBreakupType;
        }
        private set;
    }

    public class TaxBreakupType {
        public final String Detail = 'Detail';
        public final String Total = 'Total';
    }
    public static TaxAppliesTo TaxAppliesTo {
        get {
            if (TaxAppliesTo == null) {
                TaxAppliesTo = new TaxAppliesTo();
            }
            return TaxAppliesTo;
        }
        private set;
    }

    public class TaxAppliesTo {
        public final String NetPrice = 'Net Price';
        public final String BasePrice = 'Base Price';
        public final String ListPrice = 'List Price';
    }
}