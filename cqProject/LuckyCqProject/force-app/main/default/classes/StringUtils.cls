public class StringUtils {
    public static Boolean containsAny(String mainString, List<String> substrings) {
        for (String substring : substrings) {
            if (mainString.contains(substring)) {
                return true;
            }
        }
        return false;
    }
}