public with sharing class DV_CTPersonController {
    public DV_CTPersonController() {

    }
    public static String getToken(String mobile) {
        Blob targetBlob = Blob.valueOf('ExampleMD5String');
        Blob hash = Crypto.generateDigest('MD5', targetBlob);

        // get the string targetBlob of hash blob;
        return EncodingUtil.base64Encode(hash);
    }
}
