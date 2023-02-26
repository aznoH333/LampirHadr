import java.util.Scanner;

public class IpInputManager {



    private final static Scanner sc = new Scanner(System.in);
    private String input = "";

    public void getInputFromUser(){
        input = sc.nextLine();
    }

    public boolean isInputValid(){
        boolean result = true;

        int dotCounter = 0;
        StringBuilder temporaryNumber = new StringBuilder();



        for (char c : input.toCharArray()){

            if (c == '.') {
                dotCounter++;

                if (temporaryNumber.length() == 0 || temporaryNumber.length() > 3) {
                    System.out.println("invalid address");
                    result = false;
                    break;
                }

                if (Integer.parseInt(temporaryNumber.toString()) > 255){
                    System.out.println("invalid address");
                    result = false;
                    break;
                }
                temporaryNumber = new StringBuilder();


            }else {
                if (!Character.isDigit(c)){

                    System.out.println("Not a number");
                    result = false;
                    break;
                }

                temporaryNumber.append(c);
            }
        }

        if (dotCounter != 3 && result) {
            result = false;
            System.out.println("invalid address");
        }

        return result;
    }


    public long getIp(){
        long result = 0;
        String[] temp = input.split("\\.");

        for (int i = 0; i < temp.length; i++){
            result += Long.parseLong(temp[i]) * Math.pow(10,((3-i)* 3L));
        }

        return result;
    }
}
