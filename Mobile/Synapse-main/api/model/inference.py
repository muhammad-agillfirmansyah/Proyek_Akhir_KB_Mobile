import numpy as np
from PIL import Image
import tensorflow as tf

class Model:
    def __init__(self, model_path):
        self.interpreter = tf.lite.Interpreter(model_path=model_path)
        self.interpreter.allocate_tensors()

        self.input_details = self.interpreter.get_input_details()
        self.output_details = self.interpreter.get_output_details()

        self.input_shape = self.input_details[0]['shape']  # [1, 224, 224, 3]

        # Class names dari model
        self.class_names = [
            "Cassava_bacterial_blight",
            "Cassava_healthy",
            "Cassava_mosaic_disease"
        ]

        # ✨ MAPPING ke nama yang user-friendly
        self.class_display_names = {
            "Cassava_bacterial_blight": "Hawar Daun Bakteri",
            "Cassava_healthy": "Daun Sehat",
            "Cassava_mosaic_disease": "Penyakit Mosaik"
        }

        # threshold & green detection
        self.THRESHOLD = 0.60
        self.GREEN_RATIO_MIN = 0.25

    @staticmethod
    def from_path(path):
        return Model(path)

    def is_leaf_like(self, img):
        img_small = img.resize((128, 128))
        img_np = np.array(img_small)

        r = img_np[:, :, 0]
        g = img_np[:, :, 1]
        b = img_np[:, :, 2]

        green_pixels = np.sum((g > r + 20) & (g > b + 20))
        ratio = green_pixels / (128 * 128)

        return ratio > self.GREEN_RATIO_MIN, float(ratio)

    def predict_from_image(self, image_file):
        print("Model input shape:", self.input_shape)

        img = Image.open(image_file).convert("RGB")

        # Check green ratio
        leaf_like, green_ratio = self.is_leaf_like(img)
        if not leaf_like:
            return {
                "label": "Bukan Daun Singkong",
                "confidence": green_ratio,
                "reason": "Low green ratio"
            }

        h = self.input_shape[1]
        w = self.input_shape[2]

        img_resized = img.resize((w, h))
        img_np = np.array(img_resized, dtype=np.float32) / 255.0
        img_np = np.expand_dims(img_np, axis=0)

        # Predict
        self.interpreter.set_tensor(self.input_details[0]['index'], img_np)
        self.interpreter.invoke()
        output = self.interpreter.get_tensor(self.output_details[0]['index'])[0]

        pred_index = int(np.argmax(output))
        confidence = float(np.max(output))

        # Check confidence threshold
        if confidence < self.THRESHOLD:
            return {
                "label": "tidak dikenali",
                "confidence": confidence,
                "reason": "Low confidence"
            }

        # ✨ Gunakan display name dari mapping
        class_name = self.class_names[pred_index]
        display_name = self.class_display_names.get(class_name, class_name)

        return {
            "label": display_name,  # Nama yang ditampilkan
            "class_name": class_name,  # Nama asli class (opsional)
            "confidence": confidence,
            "raw_output": output.tolist()
        }