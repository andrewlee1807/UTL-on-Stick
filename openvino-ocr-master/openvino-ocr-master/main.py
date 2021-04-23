import config
if config.INFERENCE_ENGINE_TYPE == 'opencv':
    import text_detection_cv as text_detection
    import text_recognition_cv as text_recognition
else:
    import text_detection_ie as text_detection
    import text_recognition_ie as text_recognition
import cv2
import argparse

import time

# construct the argument parser and parse the arguments
# ap = argparse.ArgumentParser()
# ap.add_argument("-i", "--image", required=True, type=str, help="path to input image")
# args = vars(ap.parse_args())

def  main():
    try:
        # image = cv2.imread("openvino.jpg")
        t1 = time.time()
        image = cv2.imread("p_17.png")
        td = text_detection.PixelLinkDecoder()
        image_show, bounding_rects = td.inference(image)
        print("Time Inference : ", time.time() - t1)
        cv2.imwrite('result.png', image_show)
        cv2.imshow('Detected text', image_show)
        cv2.waitKey(0)
        cv2.destroyAllWindows()

        t2 = time.time()
        tr = text_recognition.TextRecognizer()
        # print(bounding_rects)
        # bounding_rects = [(865,210,590,15)]
        texts = tr.inference(image, bounding_rects)
        print("Time Inference : ", time.time() - t2)
        print('Result:', texts)

    except Exception as e:
        print(e)


if __name__ == '__main__':
    main()
