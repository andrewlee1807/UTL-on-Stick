import config
if config.INFERENCE_ENGINE_TYPE == 'opencv':
    import text_detection_cv as text_detection
    import text_recognition_cv as text_recognition
else:
    import text_detection_ie as text_detection
    import text_recognition_ie as text_recognition
import cv2
import time
import argparse

# construct the argument parser and parse the arguments
# ap = argparse.ArgumentParser()
# ap.add_argument("-i", "--image", required=True, type=str, help="path to input image")
# args = vars(ap.parse_args())

def  main():
    try:
        # image = cv2.imread("openvino.jpg")
        image = cv2.imread("p_05.png")
        td = text_detection.PixelLinkDecoder()
        t1 = time.time()
        image_show, bounding_rects = td.inference(image)
        print("Time Inference : ", time.time() - t1)

        cv2.imshow('Detected text', image_show)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

        t2 = time.time()
        tr = text_recognition.TextRecognizer()
        texts = tr.inference(image, bounding_rects)
        print('Result:', texts)
        print("Time Inference : ", time.time() - t2)

    

    
    except Exception as e:
        print(e)


if __name__ == '__main__':
    main()

